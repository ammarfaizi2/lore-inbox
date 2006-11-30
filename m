Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967991AbWK3X6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967991AbWK3X6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967992AbWK3X6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:58:21 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:41869 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S967991AbWK3X6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:58:21 -0500
Date: Fri, 01 Dec 2006 00:58:18 +0100
From: Vincent Legoll <legoll@online.fr>
Subject: Re: [GFS2 & DLM] Guide to -nmw tree patches
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, swhiteho@redhat.com,
       Vincent Legoll <vincent.legoll@gmail.com>
Message-id: <456F701A.8090102@online.fr>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_OaUAEwlUxzKFwZeYL/VtZQ)"
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_OaUAEwlUxzKFwZeYL/VtZQ)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Proper email threading is important for web ML archives
too...

How does the attached read to a native english speaker ?

Suggestions to put that elsewhere, or better phrasing...

Or maybe, as per akpm's tpp document suggest, this
introductory emails should be forbidden^wdiscouraged,
and the text properly dispatched in the apropriate
changelogs ?

P.S.: I'm not subscribed, and couldn't find a way to do a
proper reply to Arjan's message, so, sorry to break the
proposed rule myself...

-- 
Vincent Legoll


--Boundary_(ID_OaUAEwlUxzKFwZeYL/VtZQ)
Content-type: text/plain; name=submittingpatches.gitpatch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=submittingpatches.gitpatch

Add a suggestion to properly thread patch series

Discussion started in thread form 2006-11-30:
Re: [GFS2 & DLM] Guide to -nmw tree patches

---
commit dbdb1b56acc95508e720ba6fb04ebf8c4a5089fd
tree 6ef01b1ae85c24cb2643ef4c1de541fbfb9b583d
parent 0215ffb08ce99e2bb59eca114a99499a4d06e704
author Vincent Legoll <vincent.legoll@gmail.com> Fri, 01 Dec 2006 00:03:46 +0100
committer Vincent Legoll <vincent.legoll@gmail.com> Fri, 01 Dec 2006 00:03:46 +0100

 Documentation/SubmittingPatches |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 302d148..00f96c7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -116,6 +116,9 @@ in your patch description.
 If you cannot condense your patch set into a smaller set of patches,
 then only post say 15 or so at a time and wait for review and integration.
 
+If your patch set is not trivial, and you want to introduce the series
+with a presentation email, please post all the patches as a reply to that
+introduction, so that the whole email set is properly threaded.
 
 
 4) Select e-mail destination.

--Boundary_(ID_OaUAEwlUxzKFwZeYL/VtZQ)--

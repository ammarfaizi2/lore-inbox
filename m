Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKFLfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKFLfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 06:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKFLfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 06:35:48 -0500
Received: from main.gmane.org ([80.91.229.2]:26775 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261364AbUKFLfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 06:35:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Problem burning Audio CDs
Date: Sat, 06 Nov 2004 12:35:33 +0100
Message-ID: <yw1xis8jp5ve.fsf@ford.inprovide.com>
References: <200411061049.38278.sandersn@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:xFDXAoqwR95h+XEPe8n6N3385PM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sanders <sandersn@btinternet.com> writes:

> Hi,
>
> I've got problem with burning audio cds using k3b with 2.6.9
> onwards. It gets about 22% through and then cdrecord hangs saying
> '/usr/bin/cdrecord: Caught interrupt.'
>
> 2.6.7 works fine and I couldn't test 2.6.8.
>
> I noticed that the CPU usage is alot higher in the caes where it fails
>
> Buring data CDs and DVDs works fine.
>
> I have also just noticed audio cd ripping doesn't work.
>
> Has anyone else had this problem?

Seems to work here running 2.6.9 using a NEC DVD writer.

-- 
Måns Rullgård
mru@inprovide.com


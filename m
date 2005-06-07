Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVFGJwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVFGJwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 05:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVFGJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 05:52:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2278 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261818AbVFGJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 05:52:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050606184212.GD7947@halcrow.us> 
References: <20050606184212.GD7947@halcrow.us>  <20050603200339.GA2445@halcrow.us> <20050602054852.GB4514@sshock.rn.byu.edu> <16336.1118050922@redhat.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3, 2.6.12-rc5-mm1] eCryptfs: export user key type 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Tue, 07 Jun 2005 10:52:23 +0100
Message-ID: <26825.1118137943@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

There need to be two more changes. The prototype needs declaring in a header
file and Documentation/keys.txt needs updating.

David

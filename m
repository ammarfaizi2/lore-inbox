Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJVWqc>; Tue, 22 Oct 2002 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJVWqc>; Tue, 22 Oct 2002 18:46:32 -0400
Received: from main.gmane.org ([80.91.224.249]:43997 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261559AbSJVWqb>;
	Tue, 22 Oct 2002 18:46:31 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Linux 2.5.44-ac1
Date: Tue, 22 Oct 2002 18:53:36 -0400
Message-ID: <ap4kpq$2tf$1@main.gmane.org>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com> <20021022194511.GA29525@chunk.voxel.net>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035327098 2991 130.127.121.177 (22 Oct 2002 22:51:38 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Tue, 22 Oct 2002 22:51:38 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote:

> Note that the patch <http://chunk.mp3revolution.net/lvm2/patches/09.patch>
> is necessary for Joe's older stuff; otherwise, dm oopses (with
> 2.5.44, anyways; have not yet tried -ac1).  If you don't merge any of
> the newer DM stuff, please at least fix the lack of gendisk
> initialization...
> 

Joe's got a new set of patches on his homepage, but unfortunately they 
aren't the same ones that Alan used.  I don't suppose you have patches 1-8 
of the original set which I could use to back out the old code?  I was 
palnning on doing that and then patching in the new code.

Cheers,
Nicholas



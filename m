Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760274AbWLFGz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760274AbWLFGz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760275AbWLFGz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:55:29 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37166 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760274AbWLFGyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:54:47 -0500
Message-Id: <200612060654.kB66sWTo019252@dell2.home>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com, linux@rochester.rr.com
Subject: Re: ownership/permissions of cpio initrd 
In-reply-to: <4575D3D2.20004@mnsu.edu> 
References: <200612052007.kB5K7ntk023359@laptop13.inf.utfsm.cl> <4575D3D2.20004@mnsu.edu>
Comments: In-reply-to Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
   message dated "Tue, 05 Dec 2006 14:17:22 -0600."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19249.1165388072.1@dell2.home>
Date: Wed, 06 Dec 2006 01:54:32 -0500
From: "Marty Leisner" <linux@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> writes  on Tue, 05 Dec 20
06 14:17:22 CST
     > You can also use fakeroot(1).
     > 
     > Start fakeroot.
     > Change all of your permissions as you see fit.
     > make your cpio
     > exit fakeroot.
     > 
     > 
     > 

Thanks....I got it running on fedora4 pretty easily...

Looks like its what I want/need -- 


marty


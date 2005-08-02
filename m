Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVHBQjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVHBQjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVHBQjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:39:07 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48348 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261654AbVHBQjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:39:04 -0400
Date: Tue, 2 Aug 2005 18:39:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Michael D. Setzer II" <mikes@kuentos.guam.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel options for cd project with processor family
In-Reply-To: <42F02850.4352.1818D8B@mikes.kuentos.guam.net>
Message-ID: <Pine.LNX.4.61.0508021815110.6716@yvahk01.tjqt.qr>
References: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
 <42F02850.4352.1818D8B@mikes.kuentos.guam.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >I've built a test set of kernels with the same configuration as the 
>> >bzImage6, but changed the Processor family. Below is a list of the 
>> >build. I'm interested in which ones would make a difference. I would 
>> >think that the 386 version would probable work on all hardware, but 
>> >at what cost in performance for creating and restoring the disk 
>> >images. G4L uses basically dd, gzip, lzop, bzop, ncftpget, and 
>> >ncftpput. With all these images, the g4l iso image is 50MB. 
>> 
>> And now? Where's the question... :)
>
>I want to provide users of the G4L program with 
>the best options for the users.
>If having all the kernels is the only 
>way to provide the best options, I will have to have the users 
>download 50MB iso images. If I can get a good package with fewer 
>kernels that would make the image smaller. 
>So, to get a wide range of kernels to support various hardware, what 
>would be the best. 

The standard 586. That's what most distro [have to] use.



Jan Engelhardt
-- 

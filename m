Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbREMSVK>; Sun, 13 May 2001 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263262AbREMSVB>; Sun, 13 May 2001 14:21:01 -0400
Received: from ecstasy.ksu.ru ([193.232.252.41]:12688 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S263220AbREMSUu>;
	Sun, 13 May 2001 14:20:50 -0400
X-Pass-Through: Kazan State University network
Content-Type: text/plain; charset=US-ASCII
From: Art Boulatov <art@ksu.ru>
Organization: Kazan State University
To: Guest section DW <dwguest@win.tue.nl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux support for Microsoft dynamic disks?
Date: Sun, 13 May 2001 22:15:26 +0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk> <20010512203445.A4194@vger.timpanogas.org> <20010513124606.A7758@win.tue.nl>
In-Reply-To: <20010513124606.A7758@win.tue.nl>
MIME-Version: 1.0
Message-Id: <01051322152601.00874@artsystems.ksu.ru>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2001 02:46 pm, Guest section DW wrote:
> On Sat, May 12, 2001 at 08:34:45PM -0600, Jeff V. Merkey wrote:
> > What is your specific question?
>
> Well, my specific question would be: enough information to support
> mounting filesystems that live on a dynamic disk.
>
> Andries

Understanding the layout of a dynamic disk is just a part of the problem
as far as I can see it.
What if I have two (three,four) dynamic disks with volumes organized into a 
software stripe (raid0) under Windows?
There must be an implementation of MS' software raid in the linux kernel in 
order to access that "striped filesystem"  under linux, I'm I right?

Art.


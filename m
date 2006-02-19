Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWBSLGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWBSLGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 06:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWBSLGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 06:06:47 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:5054 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932314AbWBSLGq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 06:06:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eNBF4DtNmD5BYHrsfwya9KUmaZ0imPAEHyV1WoOZEmIZHcCkEEl7muPLFYZUd39uCPEjMNfGQxG87QnPWY0Dr7G4LILqSOSRLGJfC+tNxGRpu2jgfY+cfb4B0HlkwOCllYkkV0QZFCuokoIbcWcAMyXkR+wfA077FqlQuOObmjo=
Message-ID: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
Date: Sun, 19 Feb 2006 13:06:45 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.16-rc4: known regressions
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "John Stultz" <johnstul@us.ibm.com>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, gregkh@suse.de,
       "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Meelis Roos" <mroos@linux.ee>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060217231444.GM4422@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
> Submitter  : John Stultz <johnstul@us.ibm.com>
> Status     : still present in -git two days ago

This is not ppc only. I have the exact same problem on Gentoo
Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
Haven't had the time to investigate further yet, sorry.

                          Pekka

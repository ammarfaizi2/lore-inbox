Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSAISHG>; Wed, 9 Jan 2002 13:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSAISG4>; Wed, 9 Jan 2002 13:06:56 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:36765
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288951AbSAISGk>; Wed, 9 Jan 2002 13:06:40 -0500
Date: Wed, 9 Jan 2002 11:06:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: andersen@codepoet.org, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109180618.GO13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:54:28AM -0800, Torrey Hoffman wrote:

> The interesting thing that I currently do with initrd support is a
> custom network-booted Linux installer for an embedded system. 
> 
> I'd like to be able to do this with initramfs too.  It needs:
[snip]

Er, for this particular application, why would you use klibc, if
existant?  The initramfs stuff could work with glibc, if you didn't mind
a big enough image, it sounds like.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

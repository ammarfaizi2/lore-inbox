Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288890AbSAIGPM>; Wed, 9 Jan 2002 01:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288873AbSAIGNb>; Wed, 9 Jan 2002 01:13:31 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:9487 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288866AbSAIGMu>;
	Wed, 9 Jan 2002 01:12:50 -0500
Date: Tue, 8 Jan 2002 22:10:37 -0800
From: Greg KH <greg@kroah.com>
To: felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109061037.GB18024@kroah.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109043446.GB17655@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109043446.GB17655@kroah.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 03:53:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 08:34:47PM -0800, Greg KH wrote:
> 
> Here's what I want to have in my initramfs:
> 	- /sbin/hotplug
> 	- /sbin/modprobe
> 	- modules.dep (needed for modprobe, but is a text file)

Forgot the modules themselves.  That would be helpful...

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288606AbSAISa4>; Wed, 9 Jan 2002 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287850AbSAISaq>; Wed, 9 Jan 2002 13:30:46 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:28432 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287827AbSAISag>;
	Wed, 9 Jan 2002 13:30:36 -0500
Date: Wed, 9 Jan 2002 10:28:17 -0800
From: Greg KH <greg@kroah.com>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109182817.GA21494@kroah.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 15:55:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:54:28AM -0800, Torrey Hoffman wrote:
> - lilo

lilo?  Am I missing something, or why would you want to run lilo running
before the rest of your kernel has started up?

greg k-h

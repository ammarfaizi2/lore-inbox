Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261965AbREPRyh>; Wed, 16 May 2001 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbREPRy1>; Wed, 16 May 2001 13:54:27 -0400
Received: from mail.intrex.net ([209.42.192.246]:34573 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S261965AbREPRyK>;
	Wed, 16 May 2001 13:54:10 -0400
Date: Wed, 16 May 2001 13:55:33 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: NTFS with Win2k - Write Support broken?
Message-ID: <20010516135533.A27849@bessie.localdomain>
In-Reply-To: <Pine.LNX.4.33.0105161904160.10819-100000@neon.rayfun.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105161904160.10819-100000@neon.rayfun.org>; from axel@rayfun.org on Wed, May 16, 2001 at 07:08:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 07:08:34PM +0200, Axel Siebenwirth wrote:
> Hallo,
> 
> I have a linux system with kernel 2.4.4-ac9 and a win2k partition with
> ntfs. Since because of the new ntfs version rw support is disabled, I
> wondered how much rw support is broken, why and if I could try at least.
> Or maybe some help is appreciated?

It will trash your file system if you try to write to it.

Jim

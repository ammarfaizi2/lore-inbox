Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314010AbSDKG4t>; Thu, 11 Apr 2002 02:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314011AbSDKG4s>; Thu, 11 Apr 2002 02:56:48 -0400
Received: from zok.sgi.com ([204.94.215.101]:4496 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S314010AbSDKG4r>;
	Thu, 11 Apr 2002 02:56:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dag Bakke <dag@bakke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs-mounting loopback 
In-Reply-To: Your message of "Thu, 11 Apr 2002 09:38:15 +0200."
             <20020411093814.V31284@dagb> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 16:56:37 +1000
Message-ID: <3200.1018508197@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002 09:38:15 +0200, 
Dag Bakke <dag@bakke.com> wrote:
>2.
>"/etc/exports contains /mnt *(rw,no_root_squash,no_all_squash)"
>
>Try:
>/mnt/iso *(rw,no_root_squash,no_all_squash)

That was it.  Some days it is not worth getting out of bed :(


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSJUPWP>; Mon, 21 Oct 2002 11:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJUPWP>; Mon, 21 Oct 2002 11:22:15 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34824 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261389AbSJUPWO>;
	Mon, 21 Oct 2002 11:22:14 -0400
Date: Mon, 21 Oct 2002 08:27:19 -0700
From: Greg KH <greg@kroah.com>
To: Peter <pk@q-leap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops still occurs with usb-serial converter
Message-ID: <20021021152719.GA30984@kroah.com>
References: <S.0001127744@wolnet.de> <20021021145548.GA30857@kroah.com> <15796.7272.489462.627051@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15796.7272.489462.627051@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:25:28PM +0200, Peter wrote:
> Greg KH writes:
>  > 
>  > Does the same problem happen with usb-uhci instead of uhci?
>  > 
> 
> no, no oops, no segmentation fault!

Thanks for letting us know

(copied to lkml for others that might run across this in the future.)

thanks,

greg k-h

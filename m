Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSJLE5u>; Sat, 12 Oct 2002 00:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSJLE5u>; Sat, 12 Oct 2002 00:57:50 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52497 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262804AbSJLE5u>;
	Sat, 12 Oct 2002 00:57:50 -0400
Date: Fri, 11 Oct 2002 21:59:16 -0700
From: Greg KH <greg@kroah.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: remove unused variable in wacom driver
Message-ID: <20021012045916.GA7380@kroah.com>
References: <20021011141001.GO12432@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021011141001.GO12432@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 07:10:01AM -0700, William Lee Irwin III wrote:
> wacom.c generates the following warning:
> 
> drivers/usb/input/wacom.c: In function `wacom_probe':
> drivers/usb/input/wacom.c:405: warning: unused variable `rep_data'

Thanks, applied.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTAMRLQ>; Mon, 13 Jan 2003 12:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbTAMRLP>; Mon, 13 Jan 2003 12:11:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50181 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267862AbTAMRLP>;
	Mon, 13 Jan 2003 12:11:15 -0500
Date: Mon, 13 Jan 2003 09:20:06 -0800
From: Greg KH <greg@kroah.com>
To: Petr.Titera@whitesoft.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB
Message-ID: <20030113172006.GA7124@kroah.com>
References: <OF08F436B6.5ED0DD79-ONC1256CAD.002CEDA7-C1256CAD.002CABBA@vgd.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF08F436B6.5ED0DD79-ONC1256CAD.002CEDA7-C1256CAD.002CABBA@vgd.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 09:13:44AM +0100, Petr.Titera@whitesoft.cz wrote:
> 
> Hello,
> 
>      yes it look that this patch can work.

Great, thanks for testing this.

> But who send that signal. I tried to hack kernel to print signal
> number and it looks, that khubd gets SIGHUP.

I think it's something in the NGTL code, but I'm not really sure.

thanks,

greg k-h

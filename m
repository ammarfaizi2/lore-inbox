Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264251AbSIQPNC>; Tue, 17 Sep 2002 11:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264252AbSIQPNC>; Tue, 17 Sep 2002 11:13:02 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:40964 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264251AbSIQPNC>;
	Tue, 17 Sep 2002 11:13:02 -0400
Date: Tue, 17 Sep 2002 08:18:17 -0700
From: Greg KH <greg@kroah.com>
To: Mark C <gen-lists@blueyonder.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020917151816.GB2144@kroah.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032261937.1170.13.camel@stimpy.angelnet.internal>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:25:37PM +0100, Mark C wrote:
> 
> mount /dev/sda /mnt/camera

Did you try /dev/sda1?

thanks,

greg k-h

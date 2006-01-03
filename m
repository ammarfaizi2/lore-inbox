Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWACUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWACUiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWACUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:38:06 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:26225 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932521AbWACUiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:38:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8W+KBNisLLr6v6tYoyAd5dLkz/hocl1vzCRKggthdpaS8+xVniU/btSOqI5WI0Fq/JuAFZ1kyERqkJIhf2pdoEdL5K30pJYLfbSnDIYTBXp1k/oEtA0orLtKBqudExatSZydroKHfjcLafBXNF47gCjahYixRFzMcDpnqEzAZA=
Message-ID: <d120d5000601031238x4db9999eyc6358d2a010ad9dd@mail.gmail.com>
Date: Tue, 3 Jan 2006 15:38:03 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: usb: replace __setup("nousb") with __module_param_call
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0601031530490.18243-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103113533.6ac3e351.zaitcev@redhat.com>
	 <Pine.LNX.4.44L0.0601031530490.18243-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> usb-handoff no longer exists.  The kernel now takes USB host controllers
> away from the BIOS as soon as they are discovered.
>

Yes! YES! YEEEEES!

*Dmitry dances and rejoices*

--
Dmitry

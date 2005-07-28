Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVG1JXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVG1JXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVG1JXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:23:23 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:64722 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVG1JXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:23:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aTHaWnp2gsbXiaBHTuEv1+VWGmi7Mv5O3kQ9mCmx3ATDBrblCFtg2L2IHNcvvYGe+YJD6ZY7wfSgcNE/2ZsdJI1mi3dyw4Ud4SNgk0unLmwSmAxwi78cRskexUA/ANmh8+aBknFDEsXfAJwJh97UkG0nfByxEb/lWhXZiczzhN4=
Message-ID: <c0140e7605072802236f4c3b26@mail.gmail.com>
Date: Thu, 28 Jul 2005 11:23:21 +0200
From: cengizkirli <cengizkirli@gmail.com>
Reply-To: cengizkirli <cengizkirli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Mouse Freezes in Xorg on ASUS P4C800 Deluxe
In-Reply-To: <c0140e7605072312377b348743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0140e76050723082730836e7b@mail.gmail.com>
	 <9a8748490507230836584948c6@mail.gmail.com>
	 <c0140e7605072308424eb60d57@mail.gmail.com>
	 <c0140e7605072312377b348743@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to work after comparing my .config with Andreas Baer's and also
setting USB Support to "built-in" and not "module". Somehow the modules
are unloaded or whatever. It seems to work now. Hopefully it will last...

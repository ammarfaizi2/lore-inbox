Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVEQWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVEQWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEQWLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:11:13 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:41682 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261874AbVEQWJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=NvsbqbwP4gnxDVKv4vB4eAlLpcq/ajkP2XiDGPjhIS+3jstPoex9ns7gC+xPRb8paQ14AEH3sGD5jzURzCzqEqexxzA1wIxFL17740rtG+lJv8DV6KR42vUL1XyiV5cW1gF90trvtw2FwcAAevBAWAs869QgnZM/XHiU/f22nVE=
Date: Wed, 18 May 2005 00:09:48 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517220948.GF9121@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com> <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com> <1116363971.4989.51.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116363971.4989.51.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 04:06:11PM -0500, James Bottomley wrote:

> Well, the attached is what I'd like you to try, capturing the
> information from the initial inquiry on ... it will be quite a bit.
> 
> Hopefully it will give me a clearer idea of what's going on.

Could I just take some pictures of the boot process and send them to
you ?

Or is there any way to use an usb palm to catch the console output ?

Thank you very much,
-- 
	Grégoire Favre

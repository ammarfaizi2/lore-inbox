Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWCHSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWCHSBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCHSBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:01:30 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:54893 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751826AbWCHSBa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:01:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fr7RzLgrMarcf4JP4WMCGMiMuFoL0BezRQ3AxbIoH9FhDZzIdyeTs4mGkPAxk7/vTVhV+vvMNF2yqz4l2/SrfIUTtAhK6Rc7g2OB7PDyhIfWB4AgelU3uCOUlioIdUlKWYfSmSV4Kj7w6cRZCyhkjcnoHESRzh0X9YKVYysSXyM=
Message-ID: <d120d5000603081001p717ce263t524397abd6c96040@mail.gmail.com>
Date: Wed, 8 Mar 2006 13:01:28 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: Extra keycodes
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20060308173711.GA23254@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060223175328.GA25482@srcf.ucam.org>
	 <200602242300.58815.dtor_core@ameritech.net>
	 <20060226160730.GA5853@srcf.ucam.org>
	 <20060308173711.GA23254@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sun, Feb 26, 2006 at 04:07:30PM +0000, Matthew Garrett wrote:
>
> > Patch included. We have code to pop up battery information in
> > gnome-power-manager in response to this key being pressed, and evdev is
> > the current interface for getting the keypress event.
>
> Hi - any feedback on this?
>

Oh, I am sorry. I will add it to my tree.

--
Dmitry

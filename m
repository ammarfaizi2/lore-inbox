Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVJDMW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVJDMW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVJDMW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:22:26 -0400
Received: from free.hands.com ([83.142.228.128]:12421 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1750738AbVJDMWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:22:25 -0400
Date: Tue, 4 Oct 2005 13:22:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jason Stubbs <jstubbs@work-at.co.jp>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004122201.GN10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com> <20051003202239.GE8548@lkcl.net> <4341DBDC.2000309@work-at.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4341DBDC.2000309@work-at.co.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 10:33:16AM +0900, Jason Stubbs wrote:
> Luke Kenneth Casson Leighton wrote:
> > halving the microns should quadruple the speed: the distance is halved
> > so light has half the distance to travel and ... darn, can't remember
> > the other reason for the other factor-of-two.
> 
> 2 dimensions?
 
 Voltage-squared.  capacitance.  when you go down the microns, your
 capacitance drops and the voltage squared goes down, too.

 0.65nm is 1.2v

 0.45 is aiming for 0.9 volts.
 
 silicon germanium is going to hit a limit real soon.
 you can't go below 0.8 volts, that's the gate "off" threshold.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

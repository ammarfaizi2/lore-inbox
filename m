Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTIKNq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbTIKNq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:46:58 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:3506 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S261287AbTIKNqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:46:11 -0400
Date: Thu, 11 Sep 2003 15:46:08 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: horrible usb keyboard bug with latest tests
Message-ID: <20030911134608.GN15818@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030911125744.89506.qmail@web60207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030911125744.89506.qmail@web60207.mail.yahoo.com>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:57:44AM -0700, Mr. Mailing List wrote:
> Ok, for the last few test kernels, there is a horribly
> annoying usb keyboard bug.  after a while in X, or
> just when you start putting some input, all the
> keyboard lights on on my msnatpro keyboard.  after
> that, the keycodes  are screwed up(like the left alt
> button)
> 
> sometimes one key would stick, like
> kkkkkkkkkkkkkkkkkkkkkkkkkk

For me too, even with a normal keyboard attached to the PS/2 keyboard port.
In my case it's very rare, and not a 'constant stick' but short 'pulse' of
the same character like displaying 'kkkkkkkkk' in my terminal even if I'm
sure that I didn't forget my finger on the key. OK, it's not a showstopper
bug, but sometimes annoying. It's 2.6.0-test3 (vanilla).

I can't test 2.6.0-test4 because the machine is unusable with it: there is
no stable picture on the monitor even if I'm using ONLY VGA text console and
NOTHING else (nVidia Corporation NV6 [Vanta/Vanta LT] rev15). Screen
sometimes blank (monitor goes to sleep), sometimes the picture just jumping
crazy to random position in the video memory in case of scroll (or an effect
like this) etc. I can't test test5 yet because the lack of time, though.
 
- Gábor (larta'H)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTIMXPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTIMXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:15:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55557 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262258AbTIMXPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:15:42 -0400
Date: Sun, 14 Sep 2003 00:15:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Philip Clark <pclark@SLAC.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA in 2.6.0-test5
Message-ID: <20030914001539.D23169@flint.arm.linux.org.uk>
Mail-Followup-To: Philip Clark <pclark@SLAC.Stanford.EDU>,
	linux-kernel@vger.kernel.org
References: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>; from pclark@SLAC.Stanford.EDU on Sat, Sep 13, 2003 at 04:06:56PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 04:06:56PM -0700, Philip Clark wrote:
> Does anyone know of problems with pcmcia in test5? When I moved from
> test4 -> test5 there are now problems and I get "no sockets found"
> messages when I try to start pcmcia. If I do lspci then it detects the
> cardbus bridge no problem. Is anyone out there having similar problems? 

Please provide a full bug report - this isn't a known problem.

(Description of hardware, lspci -vv output, full kernel messages from boot
through to loading of pcmcia modules, kernel configuration, etc)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUDTWbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUDTWbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUDTWa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:30:29 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:28805 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S264502AbUDTUlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 16:41:37 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Date: Tue, 20 Apr 2004 23:41:46 +0300
User-Agent: KMail/1.6.1
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <Pine.GSO.4.58.0404191124220.21825@stekt37> <200404200756.08672.dtor_core@ameritech.net>
In-Reply-To: <200404200756.08672.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404202341.46397.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 15:56, Dmitry Torokhov wrote:

> I think the right way is to fix the issues with psmouse driver and use
> input system to tie all hardware together.

I agree 100%, and that's why I'm working on the driver. I think the biggest 
issue right now is the Fujitsu TouchScreen - I'll try to steal one of those 
laptops from work later this week and maybe come up with a solution. It has a 
Synaptics touchpad too so I get to test that as well.




Kim

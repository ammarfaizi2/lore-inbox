Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJNNCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJNNCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJNNCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:02:07 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:11976 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S264530AbUJNNB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:01:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16750.30914.666243.108593@gargle.gargle.HOWL>
Date: Thu, 14 Oct 2004 09:01:54 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Ganesan R <rganesan@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.x wrongly recognizes USB 2.0 DVD writer
In-Reply-To: <ckln33$c3e$1@sea.gmane.org>
References: <ckln33$c3e$1@sea.gmane.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ganesan> I have a NEC ND-2500A DVD writer in a ByteCC USB 2.0 external
Ganesan> enclosure.  It's recognized perfectly in 2.4.27 (Debian
Ganesan> kernel-image-2.4.27-1-686 package)

I've got a ByteCC external enclosure too, and I can't get it to work
reliably under Linux or Windows under Firewire.  I'd return it and get
something better.

Also, the 2.6 ieee1394 sbp2 driver isn't the best at detecting these
things.  And if it does, it doesn't always work well with drives in
there as well.  I've been having tons of problems and I basically gave
up.  

John

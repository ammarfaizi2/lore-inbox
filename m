Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTFLClj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTFLClj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:41:39 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:37033 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264706AbTFLClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:41:31 -0400
Date: Thu, 12 Jun 2003 12:54:42 +1000
From: CaT <cat@zip.com.au>
To: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030612025442.GA566@zip.com.au>
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz> <m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz> <m2ptlkqpej.fsf@telia.com> <20030612024814.GB4787@rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612024814.GB4787@rivenstone.net>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 10:48:14PM -0400, Joseph Fannin wrote:
> > Here is a new patch that sends ABS_ events to user space. I haven't
> > modified the XFree86 driver to handle this format yet, but I used
> > /dev/input/event* to verify that the driver generates correct data.
> 
>     How well will GPM (for example) work with this?

Aaaand... will I be able to transparently use my ps2 mouse and touchpad
without having to worry about what's plugged in at any one time?

(not trying to whinge, I just got used to having a ps2 mouse plugged in
but want to use a synaptics driver to configure certain aspects of the
touchpaf and would like the best of both worlds. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUBDKIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 05:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUBDKIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 05:08:55 -0500
Received: from hal-7.inet.it ([213.92.5.33]:55938 "EHLO hal-7.inet.it")
	by vger.kernel.org with ESMTP id S266226AbUBDKIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 05:08:36 -0500
Message-ID: <4020C492.4020008@tiscali.it>
Date: Wed, 04 Feb 2004 11:08:18 +0100
From: Koala Gnu <koala.gnu@tiscali.it>
Reply-To: koala.gnu@tiscali.it
Organization: Tiscali
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ps2 mouse
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I compiled 2.6.1 kernel on my computer and the behavior of my mouse is 
changed.
It seems to be too sensitive and then unusable.
This will happen both in text mode (using gpm) and X. The mouse works 
fine in 2.4.
I read from the mail list archive that this is not a new problem and 
several suggestions have been submitted.

I tried using:

    psmouse_noext=1

as boot parameter but it does not work.

Then I tried also with

    psmouse_rate=60 psmouse_resolution=200

but it does not work too.

I have read also the FAQ about problems in input subsystem for 2.6, but 
it seems there is no answer to my problem.

Any other suggestion?


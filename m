Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUAHMpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUAHMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:45:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:17623 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264382AbUAHMpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:45:50 -0500
Message-ID: <3FFD50F8.1020805@die-strassers.de>
Date: Thu, 08 Jan 2004 13:45:44 +0100
From: Dominik Strasser <dominik@die-strassers.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mouse wheel does not work with 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:7996899f8b3439e83b57f413cfdb276d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
my mouse, which is a Logitech cordless wheel mouse does not work fully 
under 2.6.
The wheel doesn't work; no events are sent.

The mouse is correctly identified:

mice: PS/2 mouse device common for all mice

input: PS2++ Logitech Wheel Mouse on isa0060/serio1

I already tried with "psmouse_proto=imps" as kernel parameter, but 
without success.

Any hints anybody ?

Regards

Dominik



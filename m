Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVJaPaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVJaPaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJaPaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:30:55 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:53602 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932161AbVJaPay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:30:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=Qq13Be7TDwRNGbHpCwIHY8gw9HE45nulrS1tim3OU74A1DQbcfK2NK3MCajfo0q+U4HHvuiMmFJZaJLQPL79cRXvhEg0BUYFS1eaUIIXExvGal6RRhCZjzOCpke23jLsICR2J0hM+rc3aoK7ajZqdMEu7sKg7Lh9gNOkGgVSEPc=
Message-ID: <436638A8.3000604@gmail.com>
Date: Mon, 31 Oct 2005 16:30:48 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: [BUG 2579] linux 2.6.* sound problems
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

starting from 2.6.0 (2 years ago) i have the following bug.

link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230

fast summary:
when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
file)
i hear noises, related to disk activity. more hd is used, more chicks
and ZZZZ noises happen.

linux 2.4.x and windows has no problems, perfect.
tried module/standalone alsa drivers.

Please fix that...2 years' bug!
Ready to test any patch/solution.


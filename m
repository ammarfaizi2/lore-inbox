Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVEQJ7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVEQJ7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 05:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEQJ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 05:59:50 -0400
Received: from [83.76.34.4] ([83.76.34.4]:24396 "EHLO kestrel.twibright.com")
	by vger.kernel.org with ESMTP id S261355AbVEQJ7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 05:59:48 -0400
Date: Tue, 17 May 2005 11:56:13 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: software mixing in alsa
Message-ID: <20050517095613.GA9947@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

http://www.math.tu-berlin.de/~sbartels/alsa/driver/driver.html says
"For example, there is currently ongoing work to allow mixing multiple
inputs to the pcm devices."

Does ALSA already support software mixing? If I run xmms with alsa
output plugin and then mpg123 into it, I get 'can't open /dev/dsp'
message.

Kernel version is 2.6.11-gentoo-r5

CL<


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbTAMWzt>; Mon, 13 Jan 2003 17:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268403AbTAMWzt>; Mon, 13 Jan 2003 17:55:49 -0500
Received: from [212.122.164.10] ([212.122.164.10]:8589 "EHLO pechkin.minfin.bg")
	by vger.kernel.org with ESMTP id <S268402AbTAMWzr>;
	Mon, 13 Jan 2003 17:55:47 -0500
Message-ID: <3E2346A8.7040706@minfin.bg>
Date: Tue, 14 Jan 2003 01:07:20 +0200
From: Kostadin Karaivanov <larry@minfin.bg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021203
X-Accept-Language: en-us, en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.5.57 hangs on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hardware Toshiba SatellitePro 4300;
gcc 3.2.1
kernel hangs on boot with ide-floppy build in, althogh when I compile 
ide-floppy as module
it boots and loading this module goes just fine (it even works 8-)


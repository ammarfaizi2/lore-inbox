Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTKZK42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTKZK42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:56:28 -0500
Received: from tranchant.plus.com ([81.174.183.177]:41923 "EHLO
	tranchant.plus.com") by vger.kernel.org with ESMTP id S264145AbTKZK41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:56:27 -0500
Message-ID: <3FC486D5.9090605@tranchant.plus.com>
Date: Wed, 26 Nov 2003 10:56:21 +0000
From: Mark Tranchant <mark@tranchant.plus.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error in README
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.137 () AWL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Line 122 of README in 2.6.0-test10 seems wrong. It reads:

    sudo make O=/home/name/build/kernel install_modules install

but I believe it *ought* to read:

    sudo make O=/home/name/build/kernel modules_install install

-- 
Mark Tranchant
mark@tranchant.plus.com


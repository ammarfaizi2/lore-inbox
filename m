Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272818AbTG3IbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTG3IbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:31:22 -0400
Received: from [217.222.53.238] ([217.222.53.238]:32518 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S272818AbTG3IbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:31:19 -0400
Message-ID: <3F278254.2030201@gts.it>
Date: Wed, 30 Jul 2003 10:31:16 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make install modules_install
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Shouldn't make install in kernels 2.6 perform also a modules_install?
Actually modules_install is not listed in "make help" as possible
target...

Bye

-- 
Stefano RIVOIR
GTS Srl




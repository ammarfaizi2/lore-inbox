Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbTLSD4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 22:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTLSD4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 22:56:44 -0500
Received: from cpe-24-197-142-048.spa.sc.charter.com ([24.197.142.48]:43435
	"EHLO cartman.house.org") by vger.kernel.org with ESMTP
	id S265439AbTLSD4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 22:56:43 -0500
Message-ID: <3FE276FA.2030509@charter.net>
Date: Thu, 18 Dec 2003 22:56:42 -0500
From: Brian Walker <walkerbm@charter.net>
Organization: Cable Communists
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: auto load modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I've just upgraded to 2.6.0 from 2.6.0-test6. When I boot my 
system, modules that used to load automatically like those for my 
soundcard,bttv, and serial ports(aka /dev/ttyS*) are no longer loading. 
I've gone as far as upgrading to module-init-tools-0.9.15-pre4 but 
nothing makes these modules load automatically anymore. Any ideas?

Brian


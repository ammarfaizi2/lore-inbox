Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUCIWDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUCIWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:03:39 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:30468 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S262226AbUCIWCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:02:08 -0500
Message-ID: <404E3EF0.1080905@rlknight.com>
Date: Tue, 09 Mar 2004 14:02:24 -0800
From: "Richard W. Knight" <rick_knight@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dummy network device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After I upgraded to 2.6.3 from 2.4.20 I discovered that I can only get 1 
dummy device. I need to be able to load 3 dummy network devices. 
Scouring the kernel archives, it looks like this can be accomplished 
through MODULE_PARAMS, but I can find no information on the 
module_params are or how to use them. I have dummy built as a module and 
it does load at startup as dummy0. How do I get dummy1 and dummy2?

In answering this message, please CC me.

Thanks for your help,
Rick Knight
(rick@rlknight.com)


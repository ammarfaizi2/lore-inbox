Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbUKZW76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUKZW76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUKZTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:49:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262374AbUKZT3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:04 -0500
Message-ID: <41A65D88.1020300@stud.feec.vutbr.cz>
Date: Thu, 25 Nov 2004 23:32:40 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 and x86_64; spontaneous reboots
References: <41A4D5A4.3010605@blue-labs.org> <41A4EDE2.3030309@stud.feec.vutbr.cz> <41A4F198.70607@blue-labs.org> <41A4F4CA.4030803@stud.feec.vutbr.cz> <41A5F552.2040601@blue-labs.org>
In-Reply-To: <41A5F552.2040601@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[David Ford sent me some file slightly resembling .config]

Hello David,

Could you first try to completely disable CONFIG_I2C and see if the 
kernel then survives the 5 minutes?

Michal

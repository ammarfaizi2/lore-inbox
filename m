Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbUKXVOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbUKXVOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUKXVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:14:42 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:14345 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262853AbUKXVOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:14:08 -0500
Message-ID: <41A4F4CA.4030803@stud.feec.vutbr.cz>
Date: Wed, 24 Nov 2004 21:53:30 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 and x86_64; spontaneous reboots
References: <41A4D5A4.3010605@blue-labs.org> <41A4EDE2.3030309@stud.feec.vutbr.cz> <41A4F198.70607@blue-labs.org>
In-Reply-To: <41A4F198.70607@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.1 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.6 BAYES_01               BODY: Bayesian spam probability is 1 to 10%
                              [score: 0.0987]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> Oddly, yes.  Or almost yes since I haven't measured it exactly.  The 
> typical reboot is right around five minutes of uptime.  The three times 
> that I did watch /proc/uptime, right around the 2nd column going to 300 
> seconds is when it rebooted.

Well, could you send here your .config ? Do you have some strange hardware?

Michal

PS: Please don't top-post. And the challenge-response mail filter is 
pretty annoying.

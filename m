Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWBYTdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWBYTdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWBYTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:33:37 -0500
Received: from dze141s31.ae.poznan.pl.220.254.150.in-addr.arpa ([150.254.220.184]:44241
	"EHLO dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S1161087AbWBYTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:33:36 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.4 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-3.6/2.5):. Processed in 0.755177 secs Process 20944)
Date: Sat, 25 Feb 2006 20:33:52 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1391154345.20060225203352@dns.toxicfilms.tv>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
CC: Rik van Riel <riel@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re[2]: creating live virtual files by concatenation
In-Reply-To: <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com>
References: <1271316508.20060225153749@dns.toxicfilms.tv>
 <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
 <612760535.20060225181521@dns.toxicfilms.tv>
 <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com>
 <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jesper

Saturday, February 25, 2006, 7:52:06 PM, you wrote:

> On 2/25/06, Rik van Riel <riel@redhat.com> wrote:
>> On Sat, 25 Feb 2006, Maciej Soltysiak wrote:
>>
>> > Code files, DNS zones, configuration files, HTML code. We are still
>> > dealing with lots of text files today.
>>
>> You say it like it's a bad thing, but in truth I suspect
>> people often deal with text files because they're EASY
>> to manipulate through scripts, etc.
Well, I did not mean to sound like that. My emphasis should have been
on that it sometimes is tiresome. I have no problems with plain text
files, I still am a human being, not an binary/XML parser or whatever :-D

> I can imagine quite a mess if I open a file that is really a view of
> several files and then start manipulating text in it across "actual
> file" boundaries  that could blow up easily.
Well, I meant that file to be read-only. Just a quick concatentated view
for reading.

-- 
Best regards,
Maciej



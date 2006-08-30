Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWH3Shl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWH3Shl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWH3Shl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:37:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35213 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751299AbWH3Shk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:37:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F5DA00.8050909@s5r6.in-berlin.de>
Date: Wed, 30 Aug 2006 20:33:36 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608300311430.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Tue, 29 Aug 2006, Stefan Richter wrote:
>> An easy but crude fix would be to add an according hint at the help text of
>> the immediately superordinate config option.
[...]
> You can also add a simple comment which is only visible if !SCSI.

Thanks, I will do so.
-- 
Stefan Richter
-=====-=-==- =--- ====-
http://arcgraph.de/sr/

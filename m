Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTLJAt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTLJAt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:49:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:36029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262308AbTLJAt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:49:28 -0500
X-Authenticated: #15936885
Message-ID: <3FD66D87.8030109@gmx.net>
Date: Wed, 10 Dec 2003 01:49:11 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: thornber@sistina.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Tue, 9 Dec 2003, Joe Thornber wrote:
> 
>> On Tue, Dec 09, 2003 at 11:15:08AM -0200, Marcelo Tosatti wrote:
>> > I believe 2.6 is the right place for the device mapper.
>>
>> So what's the difference between a new filesystem like XFS and a new
>> device driver like dm ?
> 
> Expected question...
> 
> XFS is a totally different filesystem from the ones present in 2.4.

Please give me a pointer about what's so different about XFS. Last time I
looked, XFS features were mostly equivalent to those of other journaling
file systems.

This is a honest question, not a flamebait.


Thanks,
Carl-Daniel


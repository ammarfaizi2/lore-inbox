Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUBSNvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUBSNvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:51:37 -0500
Received: from nefty.hu ([195.70.37.175]:28320 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S267182AbUBSNvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:51:35 -0500
Date: Thu, 19 Feb 2004 14:51:28 +0100
From: Zoltan NAGY <nagyz@nefty.hu>
Reply-To: Zoltan NAGY <nagyz@nefty.hu>
Organization: Nefty Informatics Ltd.
X-Priority: 3 (Normal)
Message-ID: <18110507100.20040219145128@nefty.hu>
To: linux-kernel@vger.kernel.org
Subject: Re[]: v2.6 in vmware?
In-Reply-To: <20040218200607.GA12982@vana.vc.cvut.cz>
References: <10ADD433537@vcnet.vc.cvut.cz> <8765e4fayx.fsf@lapper.ihatent.com>
 <20040218200607.GA12982@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr,

Wednesday, February 18, 2004, 9:06:07 PM, you wrote:
PV> On Wed, Feb 18, 2004 at 08:23:34PM +0100, Alexander Hoogerhuis wrote:
>> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
>> 
>> > On 18 Feb 04 at 14:37, Zoltan NAGY wrote:
>> > > I've been trying to get 2.6.x working in vmware4, but it drops some
>> > > oopses during init... I cannot provide details, but I'm sure that it
>> > > does not just me who are having problems with it..
>> > 
>> > Definitely you are... I do not know about any problems with running
>> > 2.6.x as a guest under VMware. 
>> > 
>> 
>> There was something about sysenter support or something in that
>> general direction; I had Zwane Mwaikambo send me a patch that worked
>> around this for pre 4.0.5 vmware, but never got around to test it as I
>> upgraded the vmware software.

> I have all reasons to believe that this is fixed in 4.0.5. It is definitely
> fixed in 4.5.

It is not working with 4.0.5. But anyway, with 4.5 it works flawlessly :)

Regards,

--
Zoltan NAGY,
Network Administrator



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSDAUzl>; Mon, 1 Apr 2002 15:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDAUzc>; Mon, 1 Apr 2002 15:55:32 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:21516 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S310434AbSDAUzT>; Mon, 1 Apr 2002 15:55:19 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7741@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'David Lawyer'" <dave@lafn.org>
Cc: "'Henrique Gobbi'" <henrique@cyclades.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Char devices drivers
Date: Mon, 1 Apr 2002 12:55:16 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 1:40 PM, David Lawyer wrote:
> 
> So eliminating cua means more work for the programmer but less 
> confusion for users.  Overall, it's a good thing since there 
> are many more users than programmers. 

Agreed, mostly. My experience is that users prefer system 
functionality that is accessible from a shell script, rather than 
requiring a source change to their app. The cua method, be it ever 
so broken on some platforms, is directly usable without programming 
to solve the most common issue - how do I get my app to talk to my 
3-wire RS-232 ports. 

Good to hear from you again. 

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


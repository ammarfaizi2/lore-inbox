Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbUCZL47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbUCZL47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:56:59 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:23719 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S264016AbUCZL46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:56:58 -0500
Message-ID: <40641A45.2060100@stesmi.com>
Date: Fri, 26 Mar 2004 12:55:49 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Binary-only firmware covered by the GPL?
References: <XFMail.20040326122022.pochini@shiny.it>
In-Reply-To: <XFMail.20040326122022.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

> On 26-Mar-2004 David Schwartz wrote:
> 
> 
>>As for "another processor", another from what processor? There is just this
>>one file. We have here a file that is allegedly distributed under the terms
>>of the GPL. It is, however, obfuscated and not the preferred form for making
>>modifications.
> 
> 
> It's my turn to make flames grow higher :)
> And about binary data which is not executed by any processor ?  Some
> cards have ASIC chips that must be programmed to make the card do
> something other than consuming power. That "code" is *not* a program
> and it's always shipped in binary form.

Shipped - yes, but how is it modified (ie edited) ?

Using a special program? That's fine then. Using a hex editor? That's
also fine. Using a VHDL compiler ? Then they need to give out the VHDL
code to it I believe. But hell, what do I know, when moving over to
hardware it's uncertain how the GPL would apply, at least to me,
and of course IANAL.

// Stefan

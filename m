Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbSIQPZy>; Tue, 17 Sep 2002 11:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264261AbSIQPZy>; Tue, 17 Sep 2002 11:25:54 -0400
Received: from tailtiu.davidcoulson.net ([194.159.178.180]:7566 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S264260AbSIQPZx>; Tue, 17 Sep 2002 11:25:53 -0400
Message-ID: <3D874ACD.3000309@davidcoulson.net>
Date: Tue, 17 Sep 2002 16:31:25 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020907
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.59-2.4.19-5
References: <200209170315.WAA04676@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 	Added /proc/mconsole, which allows UML processes to send mconsole 
> notifications to mconsole clients on the host.

I don't seem to have this in 2.4.19-4. Is there a kernel configuration 
option I'm supported to enable? I had a quick look, but I couldn't find 
anything and 'oldconfig' hasn't thrown anything interesting up recently 
which I might have missed.

David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/


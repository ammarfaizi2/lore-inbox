Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTJZXvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTJZXvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 18:51:12 -0500
Received: from orngca-mls02.socal.rr.com ([66.75.160.17]:61313 "EHLO
	orngca-mls02.socal.rr.com") by vger.kernel.org with ESMTP
	id S263122AbTJZXvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 18:51:11 -0500
Message-ID: <3F9C5DEC.2080006@greenhydrant.com>
Date: Sun, 26 Oct 2003 15:51:08 -0800
From: David Rees <drees@greenhydrant.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: wsy@merl.com
Subject: Re: compile-time error in 2.6.0-test9
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost> <200310261635.h9QGZTe13121@localhost.localdomain> <20031026171650.GD23792@localhost> <200310262319.h9QNJDr13814@localhost.localdomain>
In-Reply-To: <200310262319.h9QNJDr13814@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wsy@merl.com wrote:
> 
> Now, to figure out why I've got a bunch of unresolved symbols in 
> when I do "make modules_install".

You need an updated modutils package.  See the modules section in this 
document: http://www.codemonkey.org.uk/post-halloween-2.5.txt

-Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTFYXjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTFYXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:39:06 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.160]:23494 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S265200AbTFYXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:39:04 -0400
Message-ID: <3EFA35D3.3020408@hipac.org>
Date: Thu, 26 Jun 2003 01:52:51 +0200
From: Thomas Heinz <creatix@hipac.org>
Reply-To: Michael Bellion and Thomas Heinz <nf@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: folkert@vanheusden.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <200306252248.44224.nf@hipac.org> <200306252303.13366.folkert@vanheusden.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folkert

You wrote:
> Looks great!
> Any chance on a port to 2.5.x?

It should not be that hard to port nf-hipac to 2.5 since most of the
code (the whole hipac core) is not "kernel specific".
But since we are busy planning the next hipac extension we don't have
the time to do this ourselves.
Maybe some volunteer is willing to implement the port.


Thomas


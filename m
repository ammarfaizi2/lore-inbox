Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTISN5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTISN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:57:30 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:57995 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S261589AbTISN52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:57:28 -0400
Message-ID: <3F6B0BA2.7010801@basmevissen.nl>
Date: Fri, 19 Sep 2003 15:58:58 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does one get paid to work on the kernel?
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net> <1063958370.5520.6.camel@laptop-linux> <yw1xu179mc55.fsf@users.sourceforge.net> <3F6B0760.20905@basmevissen.nl> <yw1x7k44lwdh.fsf@users.sourceforge.net>
In-Reply-To: <yw1x7k44lwdh.fsf@users.sourceforge.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> 
>>Just wondering: what kind of use do you see for that?
> 
> For instance, to load a module required to access the suspended image.
> 

Why not loading it in the initrd image? Actually, the swsusp itself 
could (partly) be made a module if you load it in initrd :-)

Bas.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbUJ0Mt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUJ0Mt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUJ0Mtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:49:55 -0400
Received: from fep02.ttnet.net.tr ([212.156.4.131]:46078 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S262417AbUJ0MtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:49:18 -0400
Message-ID: <417F98E1.4050309@ttnet.net.tr>
Date: Wed, 27 Oct 2004 15:47:29 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Arjan van de Ven <arjan@infradead.org>, marcelo.tosatti@cyclades.com
Subject: Re: 2.4.28-rc1, more lost patches [6/10]
References: <20041027094036.KAGS6935.fep01.ttnet.net.tr@localhost> <1098871777.4680.15.camel@laptop.fenrus.org>
In-Reply-To: <1098871777.4680.15.camel@laptop.fenrus.org>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2004-10-27 at 12:40 +0300, sezeroz@ttnet.net.tr wrote:
> 
>>[6/10] cdrom: If the device is opened O_EXCL but there are
>>other openers, return busy. From ac/redhat. (by Arjan??)
> 
> 
> this is a "feature" patch not a strict bugfix, so I'm not convinced it's
> suitable for 2.4 inclusion anymore.
> 

Do you think this would change 2.4-cdrom behavior incompatibly?
It is not that extreme I think...


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272452AbTGaLi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272985AbTGaLi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:38:28 -0400
Received: from [217.222.53.238] ([217.222.53.238]:20484 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S272452AbTGaLi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:38:26 -0400
Message-ID: <3F28FFAF.80905@gts.it>
Date: Thu, 31 Jul 2003 13:38:23 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>, ianh@iahastie.clara.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
References: <3F27817A.8000703@gts.it> <200307302346.02989.ianh@iahastie.local.net> <3F28C124.9070004@gts.it> <20030731050104.1b61990d.vmlinuz386@yahoo.com.ar> <20030731111728.GB1591@eugeneteo.net>
In-Reply-To: <20030731111728.GB1591@eugeneteo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Teo wrote:

> One thing strange though.

[...]

Ok, I think I've found. It was very probably an old version of the
synaptics module for X4.3 (it was ...p3). With the new driver,
and with DRI too (along with test2-mm2 patch), it seems to be OK.
At least, I've seen no hangs so far.

Bye

-- 
Stefano RIVOIR
GTS Srl




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTILKft (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTILKfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 06:35:48 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:55945 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261376AbTILKfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 06:35:48 -0400
Date: Fri, 12 Sep 2003 07:34:37 -0300
From: Gerardo Exequiel Pozzi <djgeray2k@yahoo.com.ar>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: 2.4.23-pre2 BUG() - ACPI + sysrq power_off
Message-Id: <20030912073437.7692020d.djgeray2k@yahoo.com.ar>
In-Reply-To: <m33cf2z6cm.fsf@defiant.pm.waw.pl>
References: <m33cf2z6cm.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 2003 11:47:05 +0200, Krzysztof Halasa wrote:
>Hi,
>
>With 2.4.23-pre2 (and with some older kernels as well) I get BUG()
>after pressing sysrq+Off (power off) with ACPI.
>
>kernel/pm.c (line 159):
>

I cheked and i have the same problem with 2.4.22-ac2.

>Not checked with 2.6test yet.

yup, BUG with 2.6.0-test5.

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWA0DlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWA0DlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWA0DlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:41:14 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:2673 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030182AbWA0DlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:41:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=QiKOpahJmO7L4/TaHhGrnHfPKzjRX/aMrcW3w5TDfTlgWxkEO7xc3WPxgpG8uPUCPzms2q/CgaFt24nzVh6ORAvEq1IWiMgJW4biOE0gFoiBd1wsC9nHITil7Y6PlR3MsaOGKn1ZA33ZKwdz1W/pw+VyzAaodKpWvQUK/7Tpyd4=
Date: Fri, 27 Jan 2006 04:40:48 +0100
From: Diego Calleja <diegocg@gmail.com>
To: davids@webmaster.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-Id: <20060127044048.60dfd04b.diegocg@gmail.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEBOJLAB.davids@webmaster.com>
References: <20060127022353.GF16422@redhat.com>
	<MDEHLPKNGKAHNMBLJOLKMEBOJLAB.davids@webmaster.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 18:37:28 -0800,
"David Schwartz" <davids@webmaster.com> escribió:

> is offered for inclusion. He cannot, however, change the license on any code
> he did not write. He cannot even grant a license to any code he did not

And he's not doing it, the COPYING file applies for all the code which 
doesn't specifies its own license.


Notice that COPYING has this: "Also note that the only valid version of
the GPL as far as the kernel  is concerned is _this_ particular version
of the license (ie v2, not  v2.2 or v3.x or whatever),
unless explicitly otherwise stated."
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

(IOW, people should care about their own code, but obviously people
usually licenses their code under the same license the project uses,
except some drivers that use a dual-license scheme etc)

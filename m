Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbTCQOY4>; Mon, 17 Mar 2003 09:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbTCQOY4>; Mon, 17 Mar 2003 09:24:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55305 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S261695AbTCQOYz>;
	Mon, 17 Mar 2003 09:24:55 -0500
Date: Mon, 17 Mar 2003 08:35:47 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Breno" <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Demand paging - Kernel
Message-Id: <20030317083547.51a4004f.reynolds@redhat.com>
In-Reply-To: <004201c2eb10$1b743580$94dea7c8@bsb.virtua.com.br>
References: <004201c2eb10$1b743580$94dea7c8@bsb.virtua.com.br>
Organization: Red Hat GLS
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss
 of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Breno" <brenosp@brasilsec.com.br>, spoke thus:

> There is a possibility  to do demand paging in kernel space address ?

No.  The entire kernel, and all  of its data structures, are resident in
memory  all of  the time.   Kernel demand  paging is  not possible,  not
necessary and not implemented.


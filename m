Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTISOKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 10:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTISOKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 10:10:12 -0400
Received: from main.gmane.org ([80.91.224.249]:59536 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261567AbTISOKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 10:10:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: How does one get paid to work on the kernel?
Date: Fri, 19 Sep 2003 16:09:29 +0200
Message-ID: <yw1x3ceslvja.fsf@users.sourceforge.net>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
 <yw1xu179mc55.fsf@users.sourceforge.net> <3F6B0760.20905@basmevissen.nl>
 <yw1x7k44lwdh.fsf@users.sourceforge.net> <3F6B0BA2.7010801@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:kQuxaH04xUB4TkYDsBeec1InaeA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Mevissen <ml@basmevissen.nl> writes:

>>>Just wondering: what kind of use do you see for that?
>> For instance, to load a module required to access the suspended
>> image.
>>
>
> Why not loading it in the initrd image? Actually, the swsusp itself
> could (partly) be made a module if you load it in initrd :-)

You might want to do more than will fit in an initrd.

-- 
Måns Rullgård
mru@users.sf.net


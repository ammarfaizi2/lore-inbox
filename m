Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTJGNeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJGNeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:34:44 -0400
Received: from tri-e2k.ethz.ch ([129.132.112.23]:13376 "EHLO tri-e2k.d.ethz.ch")
	by vger.kernel.org with ESMTP id S262127AbTJGNel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:34:41 -0400
Message-ID: <3F82C0EF.1040002@debian.org>
Date: Tue, 07 Oct 2003 15:34:39 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
References: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
In-Reply-To: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2003 13:34:39.0909 (UTC) FILETIME=[C21DB550:01C38CD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:

> Hi guys,
> 
> It's been a long time that I was going to send to Linux the patch with the
> following changes, but the birth of my first child intervened and caused
> delays (though can't call them "unexpected" :). Now, if I hear from people
> "no, no! we are using this feature!"  then I will reconsider:

> Please let me know your thoughts.

Hello.

I would like to have a common model to load microcodes (and in the new boot 
procedure), but I've lost the status of such project, I think things for 2.7.
Any news?

Is microcode_ctl still maintained? I've made some correction/extentions but now 
new from the maintainer.

Intel give us the new microcode? I had contact with the new contact/maintainer/? 
person in Intel, but still no new microcode since summer 2001. So maybe before 
changing the driver, could you check the Intel vision about Linux and microcode?

ciao
	giacomo



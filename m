Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWAYKyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWAYKyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWAYKyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:54:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:19982 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751111AbWAYKyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:54:31 -0500
Date: Wed, 25 Jan 2006 10:54:18 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060125105418.GG30418@deprecation.cyrius.com>
References: <20060124181945.GA21955@deprecation.cyrius.com> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com> <20060124231409.GA29982@deprecation.cyrius.com> <200601250004.06543.dtor_core@ameritech.net> <20060125075159.GC23800@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125075159.GC23800@suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vojtech Pavlik <vojtech@suse.cz> [2006-01-25 08:51]:
> Well, USB or SCSI cores are also modules, so I think there is some point
> in having that functionality.
> 
> What were the required symbols?

input: Unknown symbol kobject_get_path
input: Unknown symbol add_input_randomness

-- 
Martin Michlmayr
http://www.cyrius.com/

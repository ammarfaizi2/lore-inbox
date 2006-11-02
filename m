Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752317AbWKBTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWKBTTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbWKBTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:19:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:19380 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752310AbWKBTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:19:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cVTx/qANuEsYAn7mrgOygyPU7zfzahu95PZhCC7vodPxhRf4louV/aI80wsdqoWlvuUkNWD1I6KqnT9oF/hEImRLn+DvzqtLXTCrCuZXfeTtwbg6ejXY1aK+YLY9tm6yJQCMavY20P4IQz0LJ4tU4vJT6ierWNtmS5iWvy3Uxd4=
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
       Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
In-Reply-To: <454A2FC2.4060107@tmr.com>
References: <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <1162048148.2723.61.camel@zelda.fubar.dk>
	 <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <20061031074946.GA7906@kroah.com>
	 <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com>
	 <20061101193134.GB29929@kroah.com>
	 <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
	 <20061101205330.GA2593@kroah.com>
	 <20061101235540.GA11581@khazad-dum.debian.net>  <454A2FC2.4060107@tmr.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 19:19:50 +0000
Message-Id: <1162495190.15948.29.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 12:49 -0500, Bill Davidsen wrote:
> And given that laptop 
> batteries run at (almost) constant voltage 

No, they really don't.

Richard.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWEOP3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWEOP3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWEOP3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:29:12 -0400
Received: from e-nvb.com ([69.27.17.200]:27813 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1751478AbWEOP3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:29:12 -0400
Subject: Re: GPL and NON GPL version modules
From: Arjan van de Ven <arjan@infradead.org>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
References: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
Content-Type: text/plain
Date: Mon, 15 May 2006 17:28:52 +0200
Message-Id: <1147706948.3013.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 15:23 +0530, Srinivas G. wrote:
> Dear All,
>  
> I have a small doubt about the GPL and NON GPL version modules.

then you should talk to a lawyer for legal advice

> 
> If I have a module called module A which uses the GPL code and module B
> uses the NON GPL (proprietary) code. If the module A depends on module
> B, is it possible to load these modules? That is some of the functions
> (which are defined in module B) are called from module A.

and explain to him how you created the modules and then ask him a few
questions like

1) at what point does the non-gpl part become a derived work of the gpl
part?
2) can I distribute A and B together, given the clause 2 of the GPL
which may restrict when you can distribute a GPL component with other
stuff?
3) how does the answer to 1) and 2) vary in different countries?
4) will you defend me in court if I follow your advice?
  (eg how sure are you of your answers)

and then listen really carefully to what your lawyer has to say on these
points, and then and only then make your own decision, based on what he
says, if you want to go forward with what you describe.


